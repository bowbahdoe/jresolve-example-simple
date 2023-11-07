import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import org.junit.jupiter.api.Test;

class TestEx {
    @Test
    void addition() {
        assertEquals(1, 1);
    }

    @Test
    void identity() {
        assertNotEquals(new a.Test(), new a.Test());
    }
}