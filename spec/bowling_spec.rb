require_relative 'spec_helper'

describe Bowling do
  let(:game) { Game.new }
  
  context "Game" do
    context "rolls & total_score" do
      specify do
        roll_list(game, [5, 4, 10, 2, 1, 5, 5, 1, 0])
        expect(game.total_score).to eq 37 # 37, not 33
        expect(game.frames.size).to eq 5
        expect(game.rolls).to eq [[5, 4], [10], [2, 1], [5, 5], [1, 0]]
        expect(game.frames.map(&:description)).to eq ["5 4", "X", "2 1", "5 /", "1 -"]
      end
    end
    
    context "next_frame_number" do
      specify do
        expect(game.next_frame_number).to eq 2
        expect{ game.roll!(10); game.roll!(10) }.to change{ game.next_frame_number }.from(2).to(3)
      end
    end
    
    context "game_over?" do
      before do
        13.times{game.roll!(10)}
      end
      
      specify do
        expect(game.game_over?).to eq true
        expect(game.total_score).to eq 300
        expect(game.frames.map(&:description)).to eq ["X", "X", "X", "X", "X", "X", "X", "X", "X", "X X X"]
      end
    end

    context 'correctly assigns rolls' do
      it "rolls one" do
        expect{game.roll!(5)}.to change{ game.frames.last.rolls }.from([]).to([5])
      end

      it "rolls two" do
        expect{roll_list(game, [5, 4])}.to change{ game.frames.last.rolls }.from([]).to([5, 4])
      end
    end
  end
  
end
