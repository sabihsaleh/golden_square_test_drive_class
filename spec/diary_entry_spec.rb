require "diary_entry"

RSpec.describe DiaryEntry do
    it "constructs" do
        diary_entry = DiaryEntry.new("my_title", "my_contents")
        expect(diary_entry.title).to eq "my_title"
        expect(diary_entry.contents).to eq "my_contents"
    end
    describe "#count_word" do
        it "returns zero if contents is empty" do
            diary_entry = DiaryEntry.new("my_title", "")
            expect(diary_entry.count_words).to eq 0
        end
        it "returns one if contents is one word" do
            diary_entry = DiaryEntry.new("my_title", "one")
            expect(diary_entry.count_words).to eq 1
        end
        it "counts the words in the contents" do
            diary_entry = DiaryEntry.new("my_title", "my_contents")
            expect(diary_entry.count_words).to eq 1
        end
    end
    describe "#reading_time" do
        it "fails if wpm is zero" do
            diary_entry = DiaryEntry.new("my_title", "hello_world")
            expect{ diary_entry.reading_time(0) }.to raise_error "WPM must be positive"
        end
        it "returns zero if contents is empty" do
            diary_entry = DiaryEntry.new("my_title", "")
            expect(diary_entry.reading_time(2)).to eq 0
        end
        it "returns one if contents is one word" do
            diary_entry = DiaryEntry.new("my_title", "one")
            expect(diary_entry.reading_time(2)).to eq 1
        end
        it "returns the reading time for the contents" do
            diary_entry = DiaryEntry.new("my_title", "one two three four five")
            expect(diary_entry.reading_time(2)).to eq 3
        end
    end
end
    