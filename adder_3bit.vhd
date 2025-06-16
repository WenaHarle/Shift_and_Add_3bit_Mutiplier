library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Komponen penjumlah 3-bit
entity adder_3bit is
    Port (
        a    : in  STD_LOGIC_VECTOR(2 downto 0);  -- Input A
        b    : in  STD_LOGIC_VECTOR(2 downto 0);  -- Input B
        sum  : out STD_LOGIC_VECTOR(2 downto 0);  -- Hasil penjumlahan
        cout : out STD_LOGIC                      -- Carry out
    );
end adder_3bit;

architecture Behavioral of adder_3bit is
    signal temp: STD_LOGIC_VECTOR(3 downto 0);  -- Sinyal sementara untuk perhitungan
begin
    temp <= ('0' & a) + ('0' & b);  -- Ekstensi bit untuk menghitung carry
    sum  <= temp(2 downto 0);       -- Output hasil
    cout <= temp(3);                -- Output carry
end Behavioral;
