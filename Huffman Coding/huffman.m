clear; close all; clc

% Message Signal
msg = 'information theory is interesting';
% Symbols
symbols ={'i' 'n' 'f' 'o' 'r' 'm' 'a' 't' ' ' 'h' 'e' 'y' 's' 'g'};         
% Assigning Probabilities
p = [5/33 4/33 1/33 3/33 3/33 1/33 1/33 4/33 1/33 3/33 1/33 2/33 1/33 3/33]; 
% Generating Huffman Coding Dictionary
[dict,avglen]=huffmandict(symbols,p);            
% DATA Encoding
binstream = huffmanenco(msg, dict);                  
% DATA Decoding
msgdeco = huffmandeco(binstream, dict); 

%% Printing the dictionary
temp=dict;
for i=1:length(temp)
temp{i,2}=num2str(temp{i,2});
end

