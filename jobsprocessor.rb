class JobsProcessor
  def process(input)
    parse_jobs(input).flatten
  end

  private
  
  def parse_jobs(input)
    jobs = []
    lines = input.split(/\n+/).select{|line| !line.strip.empty?} 
    lines.each do |line|
      parts = line.split('=>').map{|job| job.strip}
      jobs.push(parts)
    end
    jobs
  end  
end

