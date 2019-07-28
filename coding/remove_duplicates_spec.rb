require 'rspec'
require_relative 'remove_duplicates'

describe 'Remove duplicates/Iterator test' do

  context 'MyArrays test' do
    it 'Removed duplicates' do
      values = [1, 1, 2, 3, 3, 3, 4, 4, 10, 13, 15, 15, 17]
      expected_array = [1, 2, 3, 4, 10, 13, 15, 17]
      my_arrays = MyArrays.new(values)
      expect(my_arrays.remove_duplicates).to eq(expected_array)
    end

    it 'Iterator works correctly' do
      values = [1, 1, 2, 3, 3, 3, 4, 4, 10, 13, 15, 15, 17]
      array_size = values.size
      my_arrays = MyArrays.new(values)
      (array_size - 1).times do
        expect(my_arrays.next).not_to be_nil
        expect(my_arrays.has_next?).to be_truthy
      end
      my_arrays.next
      expect(my_arrays.next).to be_nil
      expect(my_arrays.has_next?).to be_falsey
    end
  end

end