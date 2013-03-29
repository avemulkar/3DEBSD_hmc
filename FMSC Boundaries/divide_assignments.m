function [current_slice_assignments,current_slice_data] = divide_assignments(assignments, data, numSlices,slice_wanted)
%Isolates assignments and data for a specific slice
%Run after FMC & interpret on a 3D data set

assign_size = length(assignments)/numSlices;
data_size = length(data)/numSlices;
% initialize variables
slice_assignments = cell(assign_size,2);
new_assignments = cell(numSlices,1);
slice_data = cell(data_size,7);
new_data = cell(numSlices,1);
s = 1;


for i = 1:numSlices;
    slice_assignments = cell(assign_size,2);
    slice_data = cell(data_size,7);
    
    for j = 1:(assign_size)
        
        slice_assignments{j,1} = assignments(s,1);
        slice_assignments{j,2} = assignments(s,2);
        slice_data{j,1} = data(s,1);
        slice_data{j,2} = data(s,2);
        slice_data{j,3} = data(s,3);
        slice_data{j,4} = data(s,4);
        slice_data{j,5} = data(s,5);
        slice_data{j,6} = data(s,6);
        slice_data{j,7} = data(s,7);
        
        s = s+1;
           
    end
    
    %assign_size
    %s 
    new_data{i} = slice_data;
    new_assignments{i} = slice_assignments;
    slice_data = [];
    slice_assignments = [];
    
end
    
current_slice_assignments = new_assignments{slice_wanted};
current_slice_assignments = cell2mat(current_slice_assignments);

current_slice_data = new_data{slice_wanted};
current_slice_data = cell2mat(current_slice_data);



end
