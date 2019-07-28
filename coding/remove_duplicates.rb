class MyArrays

  @iteration = nil
  @values = nil

  def initialize(values)
    @values = values
  end

  def remove_duplicates
    uniq_values = []
    prev_value = nil
    @values.each do |element|
      uniq_values << element if prev_value != element
      prev_value = element
    end
    uniq_values
  end

  def next
    @iteration ||= -1
    @iteration += 1
    @values[@iteration]
  end

  def has_next?
    @values.length > @iteration + 1
  end
end