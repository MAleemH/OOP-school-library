require 'spec_helper'

describe Teacher do
    before :each do
        @teacher = Teacher.new 24, "Computer Science", "Dami"
    end
    context "#new" do
        it "takes three parameters and return a teacher object" do
            expect(@teacher).to be_an_instance_of Teacher
        end
    end
end
