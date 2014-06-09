function A=getdata(name,nw)
%Function to read free-formated data A (matrix or vector) from disk.
%Numbers need not have decimal points and are delimited by white space;
%Complex numbers are represented as (+X.XXXXXX,-X.XXXXXX);
%E format is also allowed. First few entries are expected to be 'size' of data.
%
%Use: A=getdata('filename.ext')
%
%If .ext is not specified it is assumed to be .dat
%
%Updated December 1999 for complex data and multidimensional arrays
%
%Copyright (C) 1993, 1999 by Charles W. Therrien
%
if ~ischar(name), error('Argument must be a string (''filename'').'), end
if all(name ~= '.')
   name=[name,'.dat'];
end
[ft,message]=fopen(name,'r');
if ft<0
   error(message)
end
[strbf,Nchar]=fread(ft,inf,'uchar');              %read data to a string for editing
strbf=setstr(strbf);
fclose(ft);
strbf(strbf==',')=' ';                            %replace commas with spaces
lp=find(strbf=='(');                              %check for complex data
if any(lp)
   rp=find(strbf==')');	                          %assume complex data
   if length(lp)~=length(rp)
      error('Missing parentheses.')
   elseif any(rp<lp) 
      error('Unmatched parentheses.')
   else
      strbf(lp)=' ';                              %replace left perens with spaces
      [bf,N]=sscanf(strbf(lp(1):Nchar),'%g %g %*s',[2 inf]);
      bf=bf(1,:)+i*bf(2,:);
      [siz,ndim]=sscanf(strbf(1:lp(1)-1),'%g');   %check for valid size of data
      if all(siz>0 & ~mod(siz,1)) & 2*prod(siz) == N
         siz=siz.';
      else
         bf=[siz.', bf];                            %incorrect or missing size
         siz=[0];        
      end
   end
else
   [bf,N]=sscanf(strbf,'%g');                     %assume real data, 
   ndim=1;                                        %try to determine size
   siz=[bf(1)];
   while prod(siz) < N-ndim
      next=bf(ndim+1);
      if next <= 0 | mod(next,1), siz=[0]; break, end
      ndim=ndim+1;
      siz=[siz, next];
   end
   if prod(siz) == N-ndim
      bf=bf(ndim+1:N); 
   else
      siz=[0];
   end
end   
if siz                                           %reshape the data
   if ndim==1
      siz=[1 siz];
      ndim=ndim+1;
   end
   reindex=[2 1 3:ndim];                         %transpose rows and columns
   A=permute(reshape(bf,siz(reindex)),reindex);
else
   A=bf.';
   if nargin ~= 2                               %(undocumented option)
      fprintf(['\n Warning: Incorrect or missing size in file.\n',...
         ' File content is being returned as a vector.\n'])
   end
end