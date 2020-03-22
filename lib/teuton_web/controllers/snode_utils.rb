
require 'yaml'

module SnodeUtils
  ##
  # Get Snode report files from current directory
  # @return Array
  def self.get_report_files()
    file_list = []
    filenames = Dir.glob(File.join(Dir.pwd, '*.*')).sort!
    filenames.each do |filepath|
      item = { filename: File.basename(filepath) }
      next unless item[:filename].start_with? 'case-'
      item[:has_targets] = has_targets?(filepath)
      item[:grade] = SnodeUtils.get_grade(filepath)
      item[:timestamp] = SnodeUtils.get_timestamp(filepath)
      file_list << item
    end
    puts file_list
    return file_list
  end

  def self.has_targets?(filepath)
    basename = File.basename(filepath)
    return true if File.extname(basename) == '.yaml'
    return false
  end

  def self.get_grade(filepath)
    ext = File.extname(filepath)
    if ext == '.yaml'
      data = YAML.load_file(filepath)
      return data[:results][:grade]
    elsif ext == '.txt'
      data = File.read(filepath).split("\n")
      return data[data.size-2].split(' ')[3]
    end
    return 'error'
  end

  def self.get_timestamp(filepath)
    stat = File.stat(filepath).ctime
    ctime = { year: stat.year, month: stat.month, day: stat.day,
              hour: stat.hour, min: stat.min, sec: stat.sec }
    timestamp = format("%<year>04d-%<month>02d-%<day>02d %<hour>02d:%<min>02d:%<sec>02d", ctime)
    return timestamp
  end

  def self.get_raw_content(filename)
    File.read(filename)
  end

  def self.get_yaml_content(filename)
    YAML.load_file(filename)
  end

  def self.get_target(input_data, input_target_id)
    output = nil
    first = nil
    input_data[:groups].each do |group|
      group[:targets].each do |target|
        first = target if target[:target_id].to_i == 1
        output = target if target[:target_id] == input_target_id
      end
    end
    output = first if output.nil?
    output
  end
end
