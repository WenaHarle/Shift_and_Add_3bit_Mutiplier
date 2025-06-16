library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Pencacah 2-bit untuk menghitung iterasi
entity counter_2bit is
    Port (
        clk    : in  STD_LOGIC;               -- Clock
        reset  : in  STD_LOGIC;               -- Reset (aktif tinggi)
        en     : in  STD_LOGIC;               -- Enable increment
        count  : out STD_LOGIC_VECTOR(1 downto 0);  -- Output counter
        done   : out STD_LOGIC                -- Sinyal selesai (counter=3)
    );
end counter_2bit;

architecture Behavioral of counter_2bit is
    signal cnt: STD_LOGIC_VECTOR(1 downto 0);  -- Sinyal internal counter
begin
    process(clk, reset)
    begin
        if reset = '1' then         -- Reset counter ke 0
            cnt <= "00";
        elsif rising_edge(clk) then
            if en = '1' then        -- Jika enable aktif
                cnt <= cnt + 1;     -- Increment counter
            end if;
        end if;
    end process;
    
    count <= cnt;
    done  <= '1' when cnt = "11" else '0';  -- Selesai saat counter=3
end Behavioral;
