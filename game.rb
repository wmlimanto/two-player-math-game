require './player'
require './question'

class Game

  def initialize()
    print "Enter name for player 1: "
    player1 = $stdin.gets.chomp
    @player1 = Player.new(player1)

    print "Enter name for player 2: "
    player2 = $stdin.gets.chomp
    @player2 = Player.new(player2)

    @question = Question.new
    @current_player = ''

    puts "Starting Game in 3 .. 2 .. 1"
  end

  def generateQuestion
    @newQuestion = Question.new
    puts "----- NEW TURN -----"
    (@player1.turn) ? (puts "#{@player1.name}: #{@newQuestion.question}") : (puts "#{@player2.name}: #{@newQuestion.question}")
    checkAnswer
  end

  def nextTurn
    generateQuestion
  end

  def checkWinner
    if @player1.lives == 0
      puts "----- GAME OVER -----"
      puts "#{@player2.name} wins with #{@player2.lives}/3 lives remaining"
    elsif @player2.lives == 0
      puts "----- GAME OVER -----"
      puts "#{@player1.name} wins with #{@player1.lives}/3 lives remaining"
    else
      nextTurn
    end
  end

  def checkAnswer
    print "> "
    answer = gets.chomp.to_i
    if answer === @newQuestion.answer
      if @player1.turn
        puts "YES! You are correct!"
        @player1.turn = false
        @player2.turn = true
        puts "Lives remaining #{@player1.name}: #{@player1.lives}/3 #{@player2.name}: #{@player2.lives}/3"
        nextTurn
      else
        puts "YES! You are correct!"
        @player2.turn = false
        @player1.turn = true
        puts "Lives remaining #{@player2.name}: #{@player2.lives}/3 #{@player1.name}: #{@player1.lives}/3"
        nextTurn
      end
    else
      if @player1.turn
        puts "NOPE! Wrong Answer!"
        @player1.turn = false
        @player2.turn = true
        @player1.lives -= 1
        puts "Lives remaining #{@player1.name}: #{@player1.lives}/3 #{@player2.name}: #{@player2.lives}/3"
        checkWinner
      else
        puts "NOPE! Wrong Answer!"
        @player2.turn = false
        @player1.turn = true
        @player2.lives -= 1
        puts "Lives remaining #{@player2.name}: #{@player2.lives}/3 #{@player1.name}: #{@player1.lives}/3"
        checkWinner
      end
    end
  end

end
