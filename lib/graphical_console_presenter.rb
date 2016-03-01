require_relative 'console_presenter'

class GraphicalConsolePresenter < ConsolePresenter
  # Actually has a graphical representation of the hanging man
  def get_gamestate(hangman)
    text = super(hangman)
    text += "\n"
    text += draw_hangman(hangman.score)
    text
  end

  def draw_hangman(score)
    score = pictures.length - 1 if score >= pictures.length
    pictures[score]
  end

  def pictures
    @pictures ||= [
      game_over_picture,
      missing_right_leg_picture,
      missing_both_legs_picture,
      missing_both_arms_picture,
      missing_torso_picture,
      missing_head_picture,
      missing_rope_picture,
      missing_support_picture,
      missing_beam_picture,
      missing_pole_picture,
      empty_picture,
    ]
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