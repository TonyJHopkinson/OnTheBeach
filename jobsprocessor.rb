class JobsProcessor
  def process(input)
    parsed_input = parse_jobs(input)
    output = []
    counts = dependency_counts(parsed_input).sort_by{|k,v| v}.to_h	
    pending = counts.select{|k,v| v == 0}.keys 
    while (pending.length > 0) do
      pending.each do |job|
        output.push(job)
        parsed_input[job].each do |dependency|
          counts[dependency] -= 1
        end
      end
      counts.reject!{|k,v| output.include?(k)}
      pending = counts.select{|k,v| v == 0}.keys 
    end 
    raise 'Jobs cannot have circular dependencies' unless counts.empty?
    output.reverse
  end

  private
  
  def dependency_counts(input)
    input.reduce({}) do |counts,(job,dependencies)|
      unless dependencies.empty?
        if counts.has_key?(dependencies[0])
          counts[dependencies[0]] += 1
        else
          counts[dependencies[0]] = 1 
        end  
      end
      counts[job] = 0 unless counts.has_key?(job)
      counts
    end
  end
 
  def parse_jobs(input)
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

