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

  # Some helper methods to compute the drawings
  # Revert the patch that made this comment to get methods with just the ascii images
  def base_line
    "-"*11
  end

  def base_line_with_join
    base_line[0..4] + "+" + base_line[6..11]
  end

  def pole_line
    " "*5 + "|"
  end

  def beam_line
    " "*5 + "+" + "-"*12
  end

  def beam_line_with_join
    beam_line[0..-2] + "+"
  end

  def rope_line_after_support
    " "*8 + "|"
  end

  def head_after_support
    <<EOF
       _|_
      /   \\
     |     |
     |     |
      \\___/
EOF
  end

  def torso_line_after_pole
    " "*11 + "|"
  end

  def arm_line_after_pole
    " "*7 + "-"*4 + "+" + "-"*4
  end

  def hip_line_after_pole
    " "*11 + "^"
  end

  # All the drawings
  def empty_picture
    "\n"*19
  end

  def missing_pole_picture
    "\n"*18 +
    base_line + "\n"
  end

  def missing_beam_picture
    (pole_line + "\n")*18 +
    base_line_with_join + "\n"
  end

  def missing_support_picture
    beam_line + "\n" +
    (pole_line + "\n")*17 +
    base_line_with_join + "\n"
  end

  def missing_rope_picture
    beam_line + "\n" +
    pole_line + "  /\n" +
    pole_line + " /\n" +
    pole_line + "/\n" +
    (pole_line + "\n")*14 +
    base_line_with_join + "\n"
  end

  def missing_head_picture
    beam_line_with_join + "\n" +
    pole_line + "  /" + rope_line_after_support + "\n" +
    pole_line + " / " + rope_line_after_support + "\n" +
    pole_line + "/\n" +
    (pole_line + "\n")*14 +
    base_line_with_join + "\n"
  end

  def missing_torso_picture
    head_lines = head_after_support.lines # Has the newline chars in it
    beam_line_with_join + "\n" +
    pole_line + "  /" + rope_line_after_support + "\n" +
    pole_line + " / " + head_lines[0] +
    pole_line + "/  " + head_lines[1] +
    (2..4).map {|i| pole_line + "   " + head_lines[i]}.join +
    (pole_line + "\n")*11 +
    base_line_with_join + "\n"
  end

  def missing_both_arms_picture
    head_lines = head_after_support.lines # Has the newline chars in it
    beam_line_with_join + "\n" +
    pole_line + "  /" + rope_line_after_support + "\n" +
    pole_line + " / " + head_lines[0] +
    pole_line + "/  " + head_lines[1] +
    (2..4).map {|i| pole_line + "   " + head_lines[i]}.join +
    (0..4).map {pole_line + torso_line_after_pole + "\n"}.join +
    (pole_line + "\n")*6 +
    base_line_with_join + "\n"
  end

  def missing_both_legs_picture
    head_lines = head_after_support.lines # Has the newline chars in it
    beam_line_with_join + "\n" +
    pole_line + "  /" + rope_line_after_support + "\n" +
    pole_line + " / " + head_lines[0] +
    pole_line + "/  " + head_lines[1] +
    (2..4).map {|i| pole_line + "   " + head_lines[i]}.join +
    (0..1).map {pole_line + torso_line_after_pole + "\n"}.join +
    pole_line + arm_line_after_pole + "\n" +
    (0..1).map {pole_line + torso_line_after_pole + "\n"}.join +
    (pole_line + "\n")*6 +
    base_line_with_join + "\n"
  end

  def missing_right_leg_picture
    head_lines = head_after_support.lines # Has the newline chars in it
    beam_line_with_join + "\n" +
    pole_line + "  /" + rope_line_after_support + "\n" +
    pole_line + " / " + head_lines[0] +
    pole_line + "/  " + head_lines[1] +
    (2..4).map {|i| pole_line + "   " + head_lines[i]}.join +
    (0..1).map {pole_line + torso_line_after_pole + "\n"}.join +
    pole_line + arm_line_after_pole + "\n" +
    (0..1).map {pole_line + torso_line_after_pole + "\n"}.join +
    pole_line + hip_line_after_pole + "\n" +
    (0..3).map {|i| pole_line + " "*7 + " "*(3-i) + "/" + "\n"}.join +
    pole_line + "\n" +
    base_line_with_join + "\n"
  end

  def game_over_picture
    head_lines = head_after_support.lines # Has the newline chars in it
    beam_line_with_join + "\n" +
    pole_line + "  /" + rope_line_after_support + "\n" +
    pole_line + " / " + head_lines[0] +
    pole_line + "/  " + head_lines[1] +
    (2..4).map {|i| pole_line + "   " + head_lines[i]}.join +
    (0..1).map {pole_line + torso_line_after_pole + "\n"}.join +
    pole_line + arm_line_after_pole + "\n" +
    (0..1).map {pole_line + torso_line_after_pole + "\n"}.join +
    pole_line + hip_line_after_pole + "\n" +
    (0..3).map {|i| pole_line + " "*7 + " "*(3-i) + "/" + " "*(2*i+1) + "\\" + "\n"}.join +
    pole_line + "\n" +
    base_line_with_join + "\n"
  end

=begin
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
=end
end
