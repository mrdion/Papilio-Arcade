rem @echo off


set rom_path_src=..\roms
set rom_path=..\bitfiles
set romgen_path=..\romgen_source
set temp_path=tmp
set bit_file=a2601-3f
set bmm_file=%bit_file%_bd.bmm
set bit_file_path=..\bitfiles
set output_bitfile=%~n1_%bit_file%.bit
set data2mem=bin\data2mem.exe

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\%1   %temp_path%\cart_rom.bin > NUL

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %temp_path%\cart_rom.bin cart_rom 14 m  > %temp_path%\cart_rom.mem
%data2mem% -bm %bit_file_path%\%bmm_file% -bt %bit_file_path%\%bit_file%.bit -bd %temp_path%\cart_rom.mem tag avrmap.rom_code -o b %bit_file_path%\%output_bitfile%

echo done
rem pause
