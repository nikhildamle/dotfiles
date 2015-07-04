def compare(v1, v2)
	v1parts = v1.split(".")
	v2parts = v2.split(".")

	while v1parts.length < v2parts.length
		v1parts.push("0")
	end
	while v2parts.length < v1parts.length
		v2parts.push("0")
	end

	for i in 0..v1parts.length
		if v2parts.length == i
			return 1
		end

		if v1parts[i] == v2parts[i]
			next
		elsif v1parts[i] > v2parts[i]
			return 1
		else
			return -1
		end
	end

	if v1parts.length != v2parts.length
		return -1
	end
 
	return 0;
end

def sub_directories_name (path)
	files_without_current_and_parent_directories = Dir.entries(path).reject { |entry| entry == '.' || entry == '..' }
	files_without_current_and_parent_directories.select { |dir| File.directory?(File.join(path, dir)) }
end

def replace_tilde_with_home (path)
	path.dup.gsub('~', ENV['HOME'])
end

def build_tools_installed
	build_tools_location = File.join(replace_tilde_with_home(ENV['ANDROID_SDK']), "build-tools")
	sub_directories_name(build_tools_location)
end

def latest_build_tool (versions)
	latest = versions.first
	versions.map do |entry|
		latest = entry if compare(entry, latest)
	end
	return latest
end

def add_to_path(version)
	latest_build_tool_directory = "$ANDROID_SDK/build-tools/#{version}"
	return "export PATH=\"#{latest_build_tool_directory}:$PATH\""
end

def export_path
	if build_tools_installed.length != 0
		latest_version = latest_build_tool(build_tools_installed)
		return add_to_path(latest_version)
	end
end

puts export_path
