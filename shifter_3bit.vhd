library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter_3bit is
    Port (
        c_in  : in  STD_LOGIC;                -- Carry in (to become MSB of A)
        a_in  : in  STD_LOGIC_VECTOR(2 downto 0);  -- Current A register
        q_in  : in  STD_LOGIC_VECTOR(2 downto 0);  -- Current Q register
        a_out : out STD_LOGIC_VECTOR(2 downto 0);  -- Shifted A (c_in & a_in[2:1])
        q_out : out STD_LOGIC_VECTOR(2 downto 0)   -- Shifted Q (a_in[0] & q_in[2:1])
    );
end shifter_3bit;

architecture Behavioral of shifter_3bit is
begin
    -- Shift operation:
    --   a_out: MSB is c_in, then the top 2 bits of a_in (shift right by 1)
    --   q_out: MSB is the LSB of a_in, then the top 2 bits of q_in (shift right by 1)
    a_out <= c_in & a_in(2 downto 1);
    q_out <= a_in(0) & q_in(2 downto 1);
end Behavioral;
