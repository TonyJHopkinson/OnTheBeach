require_relative '../jobsparser.rb'
describe JobsParser do

  subject {described_class.new}

  describe 'parse' do
    context 'when there are no jobs' do
      it 'will return an empty hash' do
        expect(subject.parse('')).to eq ({})
      end
    end
    
    context 'when there are no dependencies' do
      let(:expected) do
        {
           'a' => [],
           'b' => []
        }
      end
      it 'it will return the job' do
         input = %{ a =>
                    b =>}
	       expect(subject.parse(input)).to eq expected
      end
    end
    
    context 'when there are multiple jobs' do      
      let(:expected) do
        {
           'a' => [],
           'b' => ['c'],
           'c' => []
        }
      end
      
      it 'it will return the jobs' do
        input = %{ a =>
                   b => c
                   c =>}
	expect(subject.parse(input)).to eq expected
      end
    end

    context 'when a job depends on itself' do
      it 'it will raise an error' do
        expect{subject.parse('c => c')}.to raise_error('A job cannot depend on itself')
      end
    end 
  end
end

