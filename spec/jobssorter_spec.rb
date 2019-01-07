require_relative '../jobssorter.rb'
describe JobsSorter do

  subject {described_class.new}

  describe 'sort' do
    context 'when there are no jobs' do
      it 'it will return an empty array' do
        expect(subject.sort({},{})).to eq []
      end
    end
    
    context 'when there are no dependencies' do
      let(:jobs) do
        {
           'a' => [],
           'b' => []
        }
      end  

      let(:counts) do
        {
          'a' => 0,
          'b' => 0
        }
      end

      it 'it will return the jobs in reverse order' do
        expect(subject.sort(jobs, counts)).to eq (['b','a'])
      end
    end
 
    context 'when there are dependencies' do
      let(:jobs) do
        {
           'a' => [],
           'b' => ['c'],
           'c' => []
        }
      end  

      let(:counts) do
        {
          'a' => 0,
          'b' => 0,
          'c' => 1
        }
      end

      it 'it will return the jobs in dependency order' do
        expect(subject.sort(jobs, counts)).to eq (['c','b','a'])
      end
    end
  end

  context 'when there are circular dependencies' do
    let(:jobs) do
      {
         'a' => [],
         'b' => ['c'],
         'c' => ['b']
      }
    end  

    let(:counts) do
      {
        'a' => 0,
        'b' => 1,
        'c' => 1
      }
    end

    it 'it will raise an error' do
      expect{subject.sort(jobs, counts)}.to raise_error('Jobs cannot have circular dependencies')
    end
  end
end

