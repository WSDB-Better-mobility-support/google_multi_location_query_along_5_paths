%  zip_file_size_dist generate a bar plot reperesenting the size of the
%  files in a folder
%   Last update: 11 January 2015

% Reference:
%   P. Pawelczak et al. (2014), "Will Dynamic Spectrum Access Drain my
%   Battery?," submitted for publication.

%   Code development: Amjed Yousef Majid (amjadyousefmajid@student.tudelft.nl),
%                     Przemyslaw Pawelczak (p.pawelczak@tudelft.nl)

% Copyright (c) 2014, Embedded Software Group, Delft University of
% Technology, The Netherlands. All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions
% are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright
% notice, this list of conditions and the following disclaimer in the
% documentation and/or other materials provided with the distribution.
%
% 3. Neither the name of the copyright holder nor the names of its
% contributors may be used to endorse or promote products derived from this
% software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
% PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
% TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
% PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
% LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

clc
clear
txt_sizes = [];
zip_sizes = [];
gzip_sizes = [];
num_of_files_to_be_read = 33 ;

txt_dir=dir('/home/amjed/Documents/Gproject/workspace/data/WSDB_DATA/txt/');
zip_dir=dir('/home/amjed/Documents/Gproject/workspace/data/WSDB_DATA/zip/');
gzip_dir=dir('/home/amjed/Documents/Gproject/workspace/data/WSDB_DATA/gzip/');

for i = 1:num_of_files_to_be_read
    % we need to use the strcmp to control the which file to read
    str  = [num2str(i) , '.txt'];
    index = strcmp({txt_dir.name}, str)
    
    txt_fileSize = txt_dir(index).bytes;
    zip_fileSize = zip_dir(index).bytes;
    tar_fileSize = gzip_dir(index).bytes;
   txt_sizes = [txt_sizes txt_fileSize];
   zip_sizes = [zip_sizes zip_fileSize];
   gzip_sizes = [gzip_sizes tar_fileSize];
end

%%
%Ploting the figures 
subplot(3,1,1)
bar(txt_sizes )
title('Plain text message sizes')
ylabel('Message size (bytes)')

subplot(3,1,2)
bar(zip_sizes , 'r' , 'EdgeColor' , 'r')
title('Zipped message sizes')
ylabel('Message size (bytes)')

subplot(3,1,3)
bar(gzip_sizes , 'g' , 'EdgeColor','g')
title('Gzipped message sizes')
ylabel('Message size (bytes)');
xlabel('Number of queries');

%%
red_zip =  (   (sum(txt_sizes) - sum(zip_sizes)) / sum(txt_sizes))  * 100 ;
fprintf('zip  overall reduction is %.2f %%  \n' , red_zip);  

red_tar =  (   (sum(txt_sizes) - sum(gzip_sizes)) / sum(txt_sizes))  * 100 ;
fprintf('tar overall reduction is %.2f %%  \n' , red_tar);  