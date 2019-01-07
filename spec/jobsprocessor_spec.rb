require_relative '../jobsprocessor.rb'
describe JobsProcessor do

  let(:parser) { double(:parser) }
  let(:counter) { double(:counter) }
  let(:sorter) { double(:sorter) }

  let(:dependencies) do
    {
      :parser => parser,
      :counter => counter,
      :sorter => sorter
    }
  end  
  subject {described_class.new(dependencies)}

  describe 'process' do
    let(:input) { :input }
    let(:parsed) { :parsed }
    let(:counts) { :counts }
    let(:sorted) { :sorted }
    it 'it will process the input' do
      expect(parser).to receive(:parse).with(input).and_return(parsed)
      expect(counter).to receive(:count).with(parsed).and_return(counts)
      expect(sorter).to receive(:sort).with(parsed, counts).and_return(sorted)
      
      expect(subject.process(input)).to eq sorted
   end
  end
end

