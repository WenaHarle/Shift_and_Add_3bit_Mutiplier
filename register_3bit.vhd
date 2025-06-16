library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Register 3-bit dengan enable dan reset
entity register_3bit is
    Port (
        clk   : in  STD_LOGIC;               -- Clock
        reset : in  STD_LOGIC;               -- Reset (aktif tinggi)
        en    : in  STD_LOGIC;               -- Enable load
        d     : in  STD_LOGIC_VECTOR(2 downto 0);  -- Data input
        q     : out STD_LOGIC_VECTOR(2 downto 0)   -- Data output
    );
end register_3bit;

architecture Behavioral of register_3bit is
begin
    process(clk, reset)
    begin
        if reset = '1' then         -- Reset semua bit ke '0'
            q <= "000";
        elsif rising_edge(clk) then -- Pada rising edge clock
            if en = '1' then        -- Jika enable aktif
                q <= d;             -- Load data
            end if;
        end if;
    end process;
end Behavioral;
