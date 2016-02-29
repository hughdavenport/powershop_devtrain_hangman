require_relative 'consolePresenter'
class GraphicalConsolePresenter < ConsolePresenter
  # Actually has a graphical representation of the hanging man

  def get_gamestate(hangman)
    text = super(hangman)
    text += "\n"
    text += draw_hangman(hangman.score)
    text
  end

  def draw_hangman(score)
    init_pictures unless @pictures
    score = @pictures.length - 1 if score >= @pictures.length
    @pictures[score]
  end

  def init_pictures
    return if @pictures
    @pictures = []
    @pictures << game_over_picture
    @pictures << missing_right_leg_picture
    @pictures << missing_both_legs_picture
    @pictures << missing_both_arms_picture
    @pictures << missing_torso_picture
    @pictures << missing_head_picture
    @pictures << missing_rope_picture
    @pictures << missing_support_picture
    @pictures << missing_beam_picture
    @pictures << missing_pole_picture
    @pictures << empty_picture
  end

  def empty_picture
    <<EOF



















EOF
  end

  def missing_pole_picture
    <<EOF


















-----------
EOF
  end

  def missing_beam_picture
    <<EOF
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_support_picture
    <<EOF
     +------------
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_rope_picture
    <<EOF
     +------------
     |  /
     | /
     |/
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_head_picture
    <<EOF
     +-----------+
     |  /        |
     | /         |
     |/
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_torso_picture
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_both_arms_picture
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |           |
     |           |
     |           |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_both_legs_picture
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |       ----+----
     |           |
     |           |
     |
     |
     |
     |
     |
     |
-----+-----
EOF
  end

  def missing_right_leg_picture
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |       ----+----
     |           |
     |           |
     |           ^
     |          /
     |         /
     |        /
     |       /
     |
-----+-----
EOF
  end

  def game_over_picture
    <<EOF
     +-----------+
     |  /        |
     | /        _|_
     |/        /   \\
     |        |     |
     |        |     |
     |         \\___/
     |           |
     |           |
     |       ----+----
     |           |
     |           |
     |           ^
     |          / \\
     |         /   \\
     |        /     \\
     |       /       \\
     |
-----+-----
EOF
  end

end
