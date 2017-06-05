pdf.setinfo("/Producer(LuaTeX-img2pdf)")

if pdf_minor_version then
	pdf.setminorversion(pdf_minor_version)
end

if pdf_compression_level then
	pdf.setcompresslevel(pdf_compression_level)
end

if pdf_object_compression_level then
	pdf.setobjcompresslevel(pdf_object_compression_level)
end

do
	local img = img
	
	local image = img.scan{ filename=image_file_name , visiblefilename="" }
	
	tex.hsize = image.width
	tex.vsize = image.height
	tex.pagewidth = image.width
	tex.pageheight = image.height
	
	img.write(image)
end

-- Execute specified chunks
do
	local i = 1
	local chunk = chunks_to_execute[1]
	while chunk do
		chunk()
		
		i = i + 1
		chunk = chunks_to_execute[i]
	end
end