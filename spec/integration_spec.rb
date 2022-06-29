require "diary"
require 'diary_entry'

RSpec.describe "integration" do
    
    it " list out the entries added" do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("my title", "my contents")
        diary_entry_2 = DiaryEntry.new("my title 2", "my contents 2")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect(diary.all).to eq [diary_entry_1, diary_entry_2]
    end
    describe "words counting behaviour" do
        it "counts the word in all diary entries contents" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my title", "my contents")
            diary_entry_2 = DiaryEntry.new("my title 2", "my contents 2")
            diary.add(diary_entry_1)
            diary.add(diary_entry_2)
            expect(diary.count_words).to eq 5
        end
    end
    describe " reading time behaviour" do
        it "fails where reading time is 0" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my title", "my contents 1")
            diary.add(diary_entry_1)
            expect { diary.reading_time(0) }.to raise_error "WPM must be positive"
        end
        it "calculate the reading time where it fits exactly" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my title", "my contents 1")
            diary_entry_2 = DiaryEntry.new("my title 2", "my contents 2")
            diary.add(diary_entry_1)
            diary.add(diary_entry_2)
            expect(diary.reading_time(2)).to eq 3
        end
        it "calculate the reading time where it falls over a minute" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my title", "my contents 1")
            diary_entry_2 = DiaryEntry.new("my title 2", "my contents 2")
            diary.add(diary_entry_1)
            diary.add(diary_entry_2)
            expect(diary.reading_time(2)).to eq 3
        end
    end
      # Returns an instance of diary entry representing the entry that is closest 
      # to, but not over, the length that the user could read in the minutes they
      # have available given their reading speed.
    describe "best reading time entry behaviour" do
        it "fails where wpm is 0" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my title", "my contents")
            diary.add(diary_entry_1)
            expect { diary.find_best_entry_for_reading_time(0, 1) }.to raise_error ("WPM must be positive")
        end            
        context "with just one entry and it is readable in time" do
            it "returns the entry" do
                diary = Diary.new
                diary_entry_1 = DiaryEntry.new("my title", "my contents")
                diary.add(diary_entry_1)
                result = diary.find_best_entry_for_reading_time(2, 1)
                expect(result).to eq diary_entry_1
            end
        end
        context "where we just have one entry and it is unreadable in the time" do
            it " returns nill" do 
                diary = Diary.new
                diary_entry_1 = DiaryEntry.new("my title", "my contents longer")
                diary.add(diary_entry_1)
                result = diary.find_best_entry_for_reading_time(2, 1)
                expect(result).to eq nil
            end
        end
        context "where we have multiple entries" do
            it "returns the longest the user can rerad in this time "do 
                diary = Diary.new
                best_entry = DiaryEntry.new("my title", "one two")
                diary.add(DiaryEntry.new("my title", "one"))
                diary.add(best_entry)
                diary.add(DiaryEntry.new("my title", "one two three"))
                diary.add(DiaryEntry.new("my title", "one two three four"))
                result = diary.find_best_entry_for_reading_time(2, 1)
                expect(result).to eq best_entry
            end
        end

    end
end