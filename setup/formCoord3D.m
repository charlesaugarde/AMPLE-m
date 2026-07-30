function [etpl,coord,ftpl,fntpl,efnum] = formCoord3D(nelsx,nelsy,nelsz,lx,ly,lz)


  % 3Dversion, CEA, JULY2026

%Two dimensional finite element grid generation
%--------------------------------------------------------------------------
% Author: William Coombs
% Date:   06/05/2015
% Description:
% Function to generate a 2D finite element grid of linear quadrilateral 
% elements.
%
%--------------------------------------------------------------------------
% [etpl,coord] = FORMCOORD2D(nelsx,nelsy,lx,ly)
%--------------------------------------------------------------------------
% Input(s):
% nelsx - number of elements in the x direction
% nelsy - number of elements in the y direction
% lx    - length in the x direction
% ly    - length in the y direction
%--------------------------------------------------------------------------
% Ouput(s);
% etpl  - element topology
% coord - nodal coordinates
%--------------------------------------------------------------------------
% See also:
%
%--------------------------------------------------------------------------

nels  = nelsx*nelsy*nelsz;                                                        % number of elements
nodes = (nelsx+1)*(nelsy+1)*(nelsz+1);                                                % number of nodes

%% node generation
coord = zeros(nodes,3);                                                     % zero coordinates 
node  = 0;                                                                  % zero node counter
for j=0:nelsy
  for i=0:nelsx
    for k=0:nelsz
      node=node+1;
      coord(node,:)=[i*lx j*ly k*lz/nelsz];
    end
  end
end
%% element generation
etpl = zeros(nels,8);                                                       % zero element topology
nel  = 0;                                                                   % zero element counter
nz = nelsz + 1;
nxz = (nelsx+1)*(nelsz+1);
for j=1:nelsy
    for i=1:nelsx
        for k=1:nelsz
            nel = nel + 1;
            n1 = (j-1)*nxz + (i-1)*nz + k;
            n2 = n1 + 1;
            n4 = n1 + nz;
            n3 = n4 + 1;
            n5 = n1 + nxz;
            n6 = n5 + 1;
            n8 = n5 + nz;
            n7 = n8 + 1;
            etpl(nel,:) = [n1 n2 n3 n4 n5 n6 n7 n8];
        end
    end
end

nfaces = (nelsx-1)*nelsy*nelsz + (nelsy-1)*nelsx*nelsz + (nelsz-1)*nelsx*nelsy;
ftpl   = zeros(nfaces,2);
fntpl  = zeros(nfaces,4);
efnum  = zeros(nfaces,2);