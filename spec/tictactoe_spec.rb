# tictactoe_spec.rb
require './lib/tictactoe'

describe Array do
  describe '#all_same?' do
    it 'is true when all elements are the same' do
      arr = Array.new(5, 'hi')
      expect(arr.all_same?).to eql(true)
    end

    it 'is false if the elements are not all the same' do
      arr = Array.new(5, 'hi').push('hello')
      expect(arr.all_same?).to eql(false)
    end
  end

  describe '#all_empty?' do
    it 'is true when all elements are empty strings' do
      arr = Array.new(5, '')
      expect(arr.all_empty?).to eql(true)
    end

    it 'is false if any elements are not empty strings' do
      arr = Array.new(5, '').push('not empty')
      expect(arr.all_empty?).to eql(false)
    end
  end
end

describe Cell do
  describe '#is_filled?' do
    it 'returns true if the cell contains a character' do
      cell = Cell.new
      cell.fill('x')
      expect(cell.is_filled?).to eql(true)
    end

    it 'returns false if the cell does not contain a character' do
      cell = Cell.new
      expect(cell.is_filled?).to eql(false)
    end
  end

  describe '#fill' do
    it 'sets the @char instance attribute to the input string' do
      cell = Cell.new
      cell.fill('x')
      expect(cell.char).to eql('x')
    end
  end
end

describe Board do
  let(:board) { Board.new }
  describe 'winner?' do
    it 'returns true if 3 same character horizontal' do
      board.fill_cell(0,0,'x')
      board.fill_cell(1,0,'x')
      board.fill_cell(2,0,'x')
      expect(board.winner?).to eql(true)
    end

    it 'returns true if 3 same character diagonal' do
      board.fill_cell(0,0,'x')
      board.fill_cell(1,1,'x')
      board.fill_cell(2,2,'x')
      expect(board.winner?).to eql(true)
    end

    it 'returns true if 3 same character vertical' do
      board.fill_cell(1,0,'x')
      board.fill_cell(1,1,'x')
      board.fill_cell(1,2,'x')
      expect(board.winner?).to eql(true)
    end

    it 'returns false otherwise' do
      board.fill_cell(1,0,'x')
      board.fill_cell(1,1,'x')
      board.fill_cell(0,1,'x')
      expect(board.winner?).to eql(false)
    end
  end

  context 'board is nearly full' do
    board = Board.new
    board.fill_cell(0, 0, 'x')
    board.fill_cell(0, 1, 'x')
    board.fill_cell(0, 2, 'x')
    board.fill_cell(1, 0, 'x')
    board.fill_cell(1, 1, 'x')
    board.fill_cell(1, 2, 'x')
    board.fill_cell(2, 0, 'x')
    board.fill_cell(2, 1, 'x')
    describe 'is_full?' do
      it 'returns false if at least one cell is empty' do
        expect(board.is_full?).to eql(false)
      end

      it 'returns true if board has every cell filled' do
        board.fill_cell(2,2,'x')
        expect(board.is_full?).to eql(true)
      end
    end
  end
end