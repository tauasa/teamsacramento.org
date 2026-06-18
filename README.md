# Team Sacramento Judo Website
![Team Sacramento Judo](img/rhodes-luz-splash.jpg)

This pom.xml defines the structure of Team Sacramento's Website beginning June, 17, 2026.

## Files

| File | Description |
|------|-------------|
| `teamsacramento.jar` | Pre-built executable JAR (Java 21) |
| `Test.java` | JUnit 5 unit tests |
| `pom.xml` | Maven build file |

## Requirements

- Java 21+ JRE to **run** the pre-built JAR
- Java 21+ JDK + Maven to **build from source**

## Usage

```bash
# Run the gui
java -jar teamsacramento.jar
# Help
java -jar teamsacramento.jar --help
```

## Build from Source

```bash
# With Maven (builds fat JAR → target/teamsacramento.jar)
mvn package

# Run tests
mvn test
```

