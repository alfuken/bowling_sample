require_relative 'spec_helper'

describe Bowling do
  let(:game) { Game.new }

  context "Frame" do
    let(:frame){Frame.new(1, game)}
    
    describe "second_roll_valid?" do
      specify "with only one roll" do
        frame.roll!(1)
        expect(frame.second_roll_valid?).to be_falsey
      end

      specify "with two rolls" do
        frame.roll!(1)
        frame.roll!(2)
        expect(frame.second_roll_valid?).to be_truthy
      end

      specify "with two invalid rolls" do
        frame.roll!(9)
        frame.roll!(9)
        expect(frame.second_roll_valid?).to be_falsey
      end

      specify "with a strike" do
        frame.roll!(10)
        frame.roll!(9)
        expect(frame.second_roll_valid?).to be_falsey
      end

      specify "with a spare" do
        frame.roll!(4)
        frame.roll!(6)
        expect(frame.second_roll_valid?).to be_truthy
      end
    end

    describe "finished?" do
      specify "on strike" do
        frame.roll!(10)
        expect(frame.finished?).to be true
      end

      specify "on one roll" do
        frame.roll!(1)
        expect(frame.finished?).to be false
      end

      specify "on two rolls" do
        frame.roll!(1)
        frame.roll!(2)
        expect(frame.finished?).to be true
      end
    end

    describe "strike_or_spare?" do
      specify "on strike" do
        frame.roll!(10)
        expect(frame.strike_or_spare?).to be true
      end

      specify "on spare" do
        frame.roll!(5)
        frame.roll!(5)
        expect(frame.strike_or_spare?).to be true
      end

      specify "on two normal rolls" do
        frame.roll!(1)
        frame.roll!(2)
        expect(frame.strike_or_spare?).to be false
      end
    end

    describe "strike?" do
      specify "on strike" do
        frame.roll!(10)
        expect(frame.strike?).to be true
      end

      specify "on spare" do
        frame.roll!(5)
        frame.roll!(5)
        expect(frame.strike?).to be false
      end

      specify "on two normal rolls" do
        frame.roll!(1)
        frame.roll!(2)
        expect(frame.strike?).to be false
      end
    end

    describe "spare?" do
      specify "on strike" do
        frame.roll!(10)
        expect(frame.spare?).to be_falsey
      end

      specify "on spare" do
        frame.roll!(5)
        frame.roll!(5)
        expect(frame.spare?).to be true
      end

      specify "on two normal rolls" do
        frame.roll!(1)
        frame.roll!(2)
        expect(frame.spare?).to be false
      end
    end
  end

end
