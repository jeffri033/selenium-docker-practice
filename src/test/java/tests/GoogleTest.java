
package tests;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import static org.junit.Assert.assertTrue;

public class GoogleTest {
    WebDriver driver;

    @Before
    public void setUp() {
        // 👇 Explicitly set path to ChromeDriver
        System.setProperty("webdriver.chrome.driver", "/usr/local/bin/chromedriver");
        System.out.println("ChromeDriver path: " + System.getProperty("webdriver.chrome.driver"));

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless", "--no-sandbox", "--disable-dev-shm-usage");
        driver = new ChromeDriver(options);
    }

    @Test
    public void testGoogleTitle() {
        driver.get("https://www.google.com");
        assertTrue(driver.getTitle().contains("Google"));
    }

    @After
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}
