require 'spec_helper'
require 'linkedin-scraper'

describe Linkedin::Profile do

  before(:all) do
    page = Nokogiri::HTML(File.open("spec/fixtures/jgrevich.html", 'r') { |f| f.read })
    @profile = Linkedin::Profile.new(page, "http://www.linkedin.com/in/jgrevich")
  end

  describe "::get_profile" do
    it "Create an instance of profile class" do
      expect(@profile).to be_instance_of Linkedin::Profile
    end
  end

  describe ".country" do
    it 'returns the country' do
      expect(@profile.country).to eq "United States"
    end
  end

  describe ".first_name" do
    it 'returns the first name' do
      expect(@profile.first_name).to eq "Justin"
    end
  end

  describe ".last_name" do
    it 'returns the last name' do
      expect(@profile.last_name).to eq "Grevich"
    end
  end
  
  describe ".languages" do
    it 'returns an array of languages hashes' do
      expect(@profile.languages.class).to eq Array
    end
    
    context 'with language data' do
      
      it 'returns an array with one language hash' do
        expect(@profile.languages.class).to eq Array
      end
      
      describe 'language hash' do        
        it 'contains the key and value for language name' do
          expect(@profile.languages.first[:language]).to eq 'English'
        end
        
        it 'contains the key and value for language proficiency' do
          expect(@profile.languages.first[:proficiency]).to eq '(Native or bilingual proficiency)'
        end
      end
    
    end # context 'with language data' do
    
  end # describe ".languages" do
  
  describe ".name" do
    it 'returns the first and last name' do
      expect(@profile.name).to eq "Justin Grevich"
    end
  end
  
  describe ".certifications" do
    it 'returns an array of certification hashes' do
      expect(@profile.certifications.class).to eq Array
      expect(@profile.certifications.count).to eq 2
    end
    
    it 'returns the certification name' do
      expect(@profile.certifications.first[:name]).to eq "CISSP"
    end

    it 'returns the certification start_date' do
      expect(@profile.certifications.first[:start_date]).to eq Date.parse('December 2010')
    end
  end

  describe ".organizations" do
    it 'returns an array of organization hashes' do
      expect(@profile.organizations.class).to eq Array
      expect(@profile.organizations.first[:name]).to eq 'San Diego Ruby'
    end
  end
  
  describe ".summary" do
    it 'returns the summary' do
      expect(@profile.summary.include?("I am a web developer and systems administrator")).to eq true
    end
  end

end
