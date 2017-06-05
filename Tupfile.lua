local test = function( size )
	if tup.getconfig("TEST_" .. string.upper(size)) == "y" then
		for compression_level = 0, 9 do
			if tup.getconfig("TEST_PDF_OBJECT_COMPRESSION") == "y" then
				for object_compression_level = 0, 9 do
					local jobname = size .. "-" .. tostring(compression_level) .. "-" .. tostring(object_compression_level)
					
					tup.definerule{
						inputs={"<required_to_use_luatex_img2pdf>"},
						command="$(TEST_COMMAND_START) --pdf-compression-level=" .. tostring(compression_level) .. " --pdf-object-compression-level=" .. tostring(object_compression_level) .. " " .. size .. ".png " .. jobname .. ".pdf",
						outputs={
							jobname .. ".log",
							jobname .. ".pdf"
						}
					}
				end
			else
				local jobname = size .. "-" .. tostring(compression_level)
				
				tup.definerule{
					inputs={"<required_to_use_luatex_img2pdf>"},
					command="$(TEST_COMMAND_START) --pdf-compression-level=" .. tostring(compression_level) .. " " .. size .. ".png " .. jobname .. ".pdf",
					outputs={
						jobname .. ".log",
						jobname .. ".pdf"
					}
				}
			end
		end
	end
end

test("small")
test("large")
test("huge")