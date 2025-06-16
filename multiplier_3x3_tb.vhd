library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier_3x3_tb is
end multiplier_3x3_tb;

architecture Behavioral of multiplier_3x3_tb is
    -- Komponen pengali yang akan diuji
    component multiplier_3x3
        Port (
            clk          : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            start        : in  STD_LOGIC;
            multiplier   : in  STD_LOGIC_VECTOR(2 downto 0);
            multiplicand : in  STD_LOGIC_VECTOR(2 downto 0);
            product      : out STD_LOGIC_VECTOR(5 downto 0);
            done         : out STD_LOGIC
        );
    end component;

    -- Sinyal input
    signal clk_tb          : STD_LOGIC := '0';
    signal reset_tb        : STD_LOGIC := '1';
    signal start_tb        : STD_LOGIC := '0';
    signal multiplier_tb   : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal multiplicand_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    
    -- Sinyal output
    signal product_tb      : STD_LOGIC_VECTOR(5 downto 0);
    signal done_tb         : STD_LOGIC;
    
    -- Konstanta periode clock
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instansiasi Unit Under Test (UUT)
    uut: multiplier_3x3 port map(
        clk          => clk_tb,
        reset        => reset_tb,
        start        => start_tb,
        multiplier   => multiplier_tb,
        multiplicand => multiplicand_tb,
        product      => product_tb,
        done         => done_tb
    );

    -- Proses pembangkit clock
    clk_process: process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Proses stimulus
    stim_proc: process
        variable expected : STD_LOGIC_VECTOR(5 downto 0);
    begin
        -- Inisialisasi sistem
        reset_tb <= '1';
        wait for CLK_PERIOD*2;
        reset_tb <= '0';
        wait for CLK_PERIOD;
        
        -- Test Case 1: 3 * 3 = 9 (0011 * 0011 = 001001)
        multiplier_tb   <= "011";  -- 3
        multiplicand_tb <= "011";  -- 3
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        -- Tunggu sampai operasi selesai
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "001001";  -- 9
        assert product_tb = expected
            report "Test Case 1 Gagal: 3*3=9" 
            severity error;
        wait for CLK_PERIOD;
        
        -- Test Case 2: 7 * 7 = 49 (0111 * 0111 = 110001)
        multiplier_tb   <= "111";  -- 7
        multiplicand_tb <= "111";  -- 7
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "110001";  -- 49
        assert product_tb = expected
            report "Test Case 2 Gagal: 7*7=49" 
            severity error;
        wait for CLK_PERIOD;
        
        -- Test Case 3: 0 * 5 = 0
        multiplier_tb   <= "000";  -- 0
        multiplicand_tb <= "101";  -- 5
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "000000";  -- 0
        assert product_tb = expected
            report "Test Case 3 Gagal: 0*5=0" 
            severity error;
        wait for CLK_PERIOD;
        
        -- Test Case 4: 1 * 6 = 6
        multiplier_tb   <= "001";  -- 1
        multiplicand_tb <= "110";  -- 6
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "000110";  -- 6
        assert product_tb = expected
            report "Test Case 4 Gagal: 1*6=6" 
            severity error;
        wait for CLK_PERIOD;
        
        -- Test Case 5: 2 * 4 = 8
        multiplier_tb   <= "010";  -- 2
        multiplicand_tb <= "100";  -- 4
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "001000";  -- 8
        assert product_tb = expected
            report "Test Case 5 Gagal: 2*4=8" 
            severity error;
        wait for CLK_PERIOD;
        
        -- Test Case 6: 7 * 1 = 7
        multiplier_tb   <= "111";  -- 7
        multiplicand_tb <= "001";  -- 1
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "000111";  -- 7
        assert product_tb = expected
            report "Test Case 6 Gagal: 7*1=7" 
            severity error;
        wait for CLK_PERIOD;
        
        -- Test Case 7: 5 * 3 = 15
        multiplier_tb   <= "101";  -- 5
        multiplicand_tb <= "011";  -- 3
        start_tb <= '1';
        wait for CLK_PERIOD;
        start_tb <= '0';
        
        wait until done_tb = '1';
        wait for CLK_PERIOD;
        expected := "001111";  -- 15
        assert product_tb = expected
            report "Test Case 7 Gagal: 5*3=15" 
            severity error;
        
        -- Berhenti simulasi
        report "Semua test selesai dijalankan";
        wait;
    end process;

end Behavioral;
