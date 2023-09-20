function output_img = stretch_log(input_img, c)
input_img=double(input_img);
dim=size(input_img);
output_img=input_img;
for i=1:dim(1)
    for j=1:dim(2)
        output_img(i,j)=c*log(input_img(i,j)+1);
    end
end
Max_Intensity_Value= max(output_img,[],'all');
Min_Intensity_Value= min(output_img,[],'all');

for i=1:dim(1)
    for j=1:dim(2)
        output_img(i,j)=(255*(output_img(i,j)- Min_Intensity_Value))/(Max_Intensity_Value - Min_Intensity_Value);
    end
end
output_img=uint8(output_img);
end
