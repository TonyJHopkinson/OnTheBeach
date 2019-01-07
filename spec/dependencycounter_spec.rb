require_relative '../dependencycounter.rb'
describe DependencyCounter do

  subject {described_class.new}

  describe 'count' do
    context 'when there are no jobs' do
      it 'will return an empty hash' do
        expect(subject.count([])).to eq ({})
      end
    end
    
    context 'when there are no dependencies' do
      let(:input) do
        {
           'a' => [],
           'b' => [],
           'c' => []
        }
      end

      it 'each job will appear in the result' do
        expect(subject.count(input).length).to eq input.length
      end
      
      it 'each job will have a count of 0' do
        expect(subject.count(input).values.select{|c| c== 0}.length).to eq input.length
      end 
    end
    
    context 'when there are dependencies' do
       let(:input) do
        {
           'a' => [],
           'b' => ['c'],
           'c' => []
        }
      end

      it 'each job will appear in the result' do
        expect(subject.count(input).length).to eq input.length
      end
      
      it 'each job with which no other job is dependent on will have a count of 0' do
        expect(subject.count(input).values.select{|c| c == 0}.length).to eq (input.length - 1)
      end 

      it 'Job c will have a count of 1 as b is dependent on it' do
        expect(subject.count(input)['c']).to eq 1
      end 
    end
  end
end

