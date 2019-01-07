class DependencyCounter
  def count(input)
    result = input.reduce({}) do |counts,(job,dependencies)|
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
    result.sort_by{|k,v| v}.to_h
  end
end

