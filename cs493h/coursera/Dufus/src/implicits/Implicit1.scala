package implicits
import javax.swing.JButton
import java.awt.event.ActionEvent
import java.awt.event.ActionListener

object Button {
  import Implicits1._
  val button = new JButton
  button.addActionListener(
    new ActionListener {
      def actionPerformed(event: ActionEvent) {
        println("pressed!")
      }
    })

  button.addActionListener(
    (_: ActionEvent) => println("pressed!"))
}

object Implicits1 {
  implicit def function2ActionListener(f: ActionEvent => Unit) : ActionListener =
    new ActionListener {
      def actionPerformed(event: ActionEvent) = f(event)
    }
}