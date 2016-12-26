module SchemaToScaffold
  RSpec.describe Help do
    describe ".message" do
      it "returns message for darwin platform" do
        allow(Help).to receive(:platform).and_return("darwin")
        expect(Help.message).to include("work/rails/my_app/")
      end

      it "returns message for linux platform" do
        allow(Help).to receive(:platform).and_return("linux")
        expect(Help.message).to include("work/rails/my_app/")
      end

      it "returns message for windows(win) platform" do
        allow(Help).to receive(:platform).and_return("win")
        expect(Help.message).to include("JohnDoe\\Documents")
      end

      it "returns message for windows (mingw) platform" do
        allow(Help).to receive(:platform).and_return("mingw")
        expect(Help.message).to include("JohnDoe\\Documents")
      end
    end
  end
end