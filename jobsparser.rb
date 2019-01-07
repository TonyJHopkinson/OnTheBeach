class JobsParser
  def parse(input)
    lines = input.split(/\n+/).select{|line| !line.strip.empty?} 
    lines.reduce({}) do |jobs,line|
      parts = line.split('=>').map{|job| job.strip}
      if parts.length == 1
        jobs[parts[0]] = []
      else
        if parts[0] == parts[1]
          raise 'A job cannot depend on itself'
        else
          jobs[parts[0]] = [parts[1]] 
        end
      end  
      jobs 
    end
  end  
end

