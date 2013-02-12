def matching_rule(line)
	regex = "^(POST|GET) \/.* HTTP\/1\.1$\n(^(Accept|Host|Referer): .*$)*\n{1,2}(.*)?"

	line.match(regex).nil? ? false : true
end


files = Dir.entries "./requests"

files.reject!{|x| [".",".."].include? x}

for file in files
	x = File.open("./requests/#{file}").read

	if matching_rule x
		puts "#{file} is valid."
	else
		puts "#{file} is invalid. It should follow the following form:"

		puts "METHOD (GET || POST) <uri> HTTP/1.1"
		puts "HEADER (Accept||Referer||Host: <value>)"
		puts "<blank line>"
		puts "<body>"
	end
end
