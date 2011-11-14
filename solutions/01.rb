

class Array
  
  def to_hash  
    hash = {}
    self.each do |element_array|
      hash[element_array[0]] = element_array[1] 
    end
    hash
  end
  
  def index_by  
    self.map { |element| [yield(element), element] }.to_hash
  end
  
  def subarray_count(subarray)
    i = 0
    subarray_length = subarray.length
    arr_length = self.length
    subarray_counter = 0
    
    (0..(arr_length-subarray_length)).each do |i|
      if self[i..i+subarray_length-1] == subarray then subarray_counter+=1
      end
    end
    return subarray_counter
  end
  
  def occurences_count
    new_hash = {}  
    new_hash = Hash.new(0)
    
    self.each() do |element|
      new_hash[element] = subarray_count([element])
    end
    
    return new_hash
    
  end
end

