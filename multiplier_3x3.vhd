library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Top level: Pengali biner 3x3 bit
entity multiplier_3x3 is
    Port (
        clk          : in  STD_LOGIC;                    -- Clock
        reset        : in  STD_LOGIC;                    -- Reset (aktif tinggi)
        start        : in  STD_LOGIC;                    -- Sinyal mulai
        multiplier   : in  STD_LOGIC_VECTOR(2 downto 0); -- Input pengali
        multiplicand : in  STD_LOGIC_VECTOR(2 downto 0); -- Input yang dikali
        product      : out STD_LOGIC_VECTOR(5 downto 0); -- Hasil perkalian (6-bit)
        done         : out STD_LOGIC                     -- Sinyal selesai
    );
end multiplier_3x3;

architecture Structural of multiplier_3x3 is
    -- Deklarasi komponen
    component adder_3bit
        Port ( a    : in  STD_LOGIC_VECTOR(2 downto 0);
               b    : in  STD_LOGIC_VECTOR(2 downto 0);
               sum  : out STD_LOGIC_VECTOR(2 downto 0);
               cout : out STD_LOGIC);
    end component;
    
    component register_3bit
        Port ( clk   : in  STD_LOGIC;
               reset : in  STD_LOGIC;
               en    : in  STD_LOGIC;
               d     : in  STD_LOGIC_VECTOR(2 downto 0);
               q     : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component counter_2bit
        Port ( clk    : in  STD_LOGIC;
               reset  : in  STD_LOGIC;
               en     : in  STD_LOGIC;
               count  : out STD_LOGIC_VECTOR(1 downto 0);
               done   : out STD_LOGIC);
    end component;
    
    component control_unit
        Port ( clk      : in  STD_LOGIC;
               reset    : in  STD_LOGIC;
               start    : in  STD_LOGIC;
               Q0       : in  STD_LOGIC;
               cnt_done : in  STD_LOGIC;
               load     : out STD_LOGIC;
               shift    : out STD_LOGIC;
               add      : out STD_LOGIC;
               done     : out STD_LOGIC);
    end component;
    
    component shifter_3bit
        Port ( c_in  : in  STD_LOGIC;
               a_in  : in  STD_LOGIC_VECTOR(2 downto 0);
               q_in  : in  STD_LOGIC_VECTOR(2 downto 0);
               a_out : out STD_LOGIC_VECTOR(2 downto 0);
               q_out : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    -- Sinyal internal
    signal load_sig, shift_sig, add_sig, cnt_done_sig, cout_sig, Q0_sig : STD_LOGIC;
    signal adder_out, A_reg, B_reg, Q_reg, A_in, Q_in : STD_LOGIC_VECTOR(2 downto 0);
    signal cnt_out : STD_LOGIC_VECTOR(1 downto 0);
    signal C_reg, C_in : STD_LOGIC;
    signal reset_counter : STD_LOGIC;
    signal shifted_A, shifted_Q : STD_LOGIC_VECTOR(2 downto 0);
    
begin
    -- Instansiasi Unit Kontrol
    CU: control_unit port map(
        clk      => clk,
        reset    => reset,
        start    => start,
        Q0       => Q_reg(0),  -- LSB register pengali
        cnt_done => cnt_done_sig,
        load     => load_sig,
        shift    => shift_sig,
        add      => add_sig,
        done     => done
    );
    
    -- Instansiasi Adder 3-bit
    ADDER: adder_3bit port map(
        a    => A_reg,
        b    => B_reg,
        sum  => adder_out,
        cout => cout_sig
    );
    
    -- Instansiasi Register A (Akumulator)
    REG_A: register_3bit port map(
        clk   => clk,
        reset => reset,
        en    => '1',  -- Selalu aktif (diupdate setiap siklus)
        d     => A_in,
        q     => A_reg
    );
    
    -- Instansiasi Register B (Penyimpan Multiplicand)
    REG_B: register_3bit port map(
        clk   => clk,
        reset => reset,
        en    => load_sig,  -- Load hanya saat inisialisasi
        d     => multiplicand,
        q     => B_reg
    );
    
    -- Instansiasi Register Q (Pengali)
    REG_Q: register_3bit port map(
        clk   => clk,
        reset => reset,
        en    => '1',  -- Selalu aktif
        d     => Q_in,
        q     => Q_reg
    );
    
    -- Counter reset logic: reset or load signal
    reset_counter <= reset or load_sig;
    
    -- Instansiasi Counter
    CNT: counter_2bit port map(
        clk    => clk,
        reset  => reset_counter,  -- Reset saat load atau global reset
        en     => shift_sig,      -- Increment saat shift
        count  => cnt_out,
        done   => cnt_done_sig
    );
    
    -- Instansiasi Shifter
    SHIFTER: shifter_3bit port map(
        c_in  => C_reg,
        a_in  => A_reg,
        q_in  => Q_reg,
        a_out => shifted_A,
        q_out => shifted_Q
    );
    
    -- Flip-flop untuk Carry (C)
    process(clk, reset)
    begin
        if reset = '1' then
            C_reg <= '0';
        elsif rising_edge(clk) then
            C_reg <= C_in;
        end if;
    end process;
    
    -- Logika kombinasi untuk input register A, Q, dan C
    process(load_sig, add_sig, shift_sig, A_reg, Q_reg, C_reg, adder_out, cout_sig, shifted_A, shifted_Q)
    begin
        -- Default: Pertahankan nilai saat ini
        A_in <= A_reg;
        Q_in <= Q_reg;
        C_in <= C_reg;
        
        if load_sig = '1' then 
            -- Inisialisasi: A=0, Q=multiplier, C=0
            A_in <= "000";
            Q_in <= multiplier;
            C_in <= '0';
        elsif add_sig = '1' then 
            -- Update A dan C hasil penjumlahan
            A_in <= adder_out;
            C_in <= cout_sig;
        elsif shift_sig = '1' then 
            -- Geser kanan: [C, A, Q] 
            A_in <= shifted_A;
            Q_in <= shifted_Q;
            C_in <= '0';  -- Reset carry setelah geser
        end if;
    end process;
    
    -- Output hasil perkalian (gabungan A dan Q)
    product <= A_reg & Q_reg;
    Q0_sig <= Q_reg(0);  -- Sinyal LSB Q untuk kontrol
end Structural;
