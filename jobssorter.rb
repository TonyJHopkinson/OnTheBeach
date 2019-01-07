class JobsSorter
  def sort(jobs, counts)
    output = []
    pending = counts.select{|k,v| v == 0}.keys 
    while (pending.length > 0) do
      pending.each do |job|
        output.push(job)
        jobs[job].each do |dependency|
          counts[dependency] -= 1
        end
      end
      counts.reject!{|k,v| output.include?(k)}
      pending = counts.select{|k,v| v == 0}.keys 
    end 
    raise 'Jobs cannot have circular dependencies' unless counts.empty?
    output.reverse
  end
end

