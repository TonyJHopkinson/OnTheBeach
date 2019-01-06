require_relative '../jobsprocessor.rb'
describe JobsProcessor do

  subject {described_class.new}

  describe 'process' do
    context 'when there are no jobs' do
      it 'will return an empty string' do
        expect(subject.process('')).to eq []
      end
    end
    
    context 'when there is one job' do
      it 'it will return the job' do
        expect(subject.process('a =>')).to eq ['a']
      end
    end
    
    context 'when there are multiple jobs' do
      
     it 'it will return the jobs' do
        input = %{ a =>
                   b =>
                   c =>}
	actual = subject.process(input)
        expect(actual.length).to eq 3
        expect(actual.include?('a')).to be true
        expect(actual.include?('b')).to be true
        expect(actual.include?('c')).to be true       
      end
    end
    
    context 'and there are dependencies' do
      let(:input) {%( a =>
                      b => c
                      c =>) 
                  }
      it 'it will return the jobs' do
	actual = subject.process(input)
        expect(actual.length).to eq 3
        expect(actual.include?('a')).to be true
        expect(actual.include?('b')).to be true
        expect(actual.include?('c')).to be true       
      end

      it 'the dependent job precedes the one it is dependent on' do
        actual = subject.process(input)
        expect(actual.index('c')).to be < actual.index('b')
      end
    end

    context 'and there are multiple dependencies' do
      let(:input) {%( a =>
                      b => c
                      c => f
                      d => a
                      e => b
                      f =>) 
                  }
      it 'it will return the jobs' do
	actual = subject.process(input)
        expect(actual.length).to eq 6
        expect(actual.include?('a')).to be true
        expect(actual.include?('b')).to be true
        expect(actual.include?('c')).to be true       
        expect(actual.include?('d')).to be true       
        expect(actual.include?('e')).to be true       
        expect(actual.include?('f')).to be true       
       end

      it 'the dependent job precedes the one it is dependent on' do
        actual = subject.process(input)
        expect(actual.index('c')).to be < actual.index('b')
        expect(actual.index('f')).to be < actual.index('c')
        expect(actual.index('a')).to be < actual.index('d')
        expect(actual.index('b')).to be < actual.index('e')
       end
    end

    context 'and a job that depends on itself' do
      let(:input) {%( a =>
                      b =>
                      c => c) 
                  }
      it 'will raise an error' do
        expect(subject.process(input)).to raise_error('A job cannot depend on itself')
      end
    end

    context 'and a job list has a circular reference' do
      let (:input) { %( a =>
                        b => c
                        c => f
                        d => a
                        e =>
                        f => b)
                   }
      it 'will raise an error' do
        expect(subject.process(input)).to raise_error('Jobs cannot have circulardependences')
      end
    end
  end
end

