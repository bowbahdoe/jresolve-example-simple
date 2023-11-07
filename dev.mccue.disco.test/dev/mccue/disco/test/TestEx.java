package dev.mccue.disco.test;

import static dev.mccue.disco.util.Wow.plusOne;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import dev.mccue.disco.util.Apple;
import org.junit.jupiter.api.Test;

public class TestEx {

  @Test
  public void addition() {
    assertEquals(2, plusOne(1));
  }

  @Test
  public void testApple() {
    var apple = new Apple();
    assertEquals(null, apple.getColor());
    apple.setColor("red");
    assertEquals("red", apple.getColor());
  }
}
