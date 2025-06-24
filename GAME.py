import pygame
import random
import sys

# Initialize Pygame
pygame.init()

# Constants
WIDTH, HEIGHT = 600, 600
ROWS, COLS = 10, 10
CELL_SIZE = WIDTH // COLS
screen = pygame.display.set_mode((WIDTH, HEIGHT + 100))
pygame.display.set_caption("Snake and Ladders")

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
DARK_BLUE = (25, 25, 112)
DARK_GRAY = (50, 50, 50)
TEXT_COLOR = (255, 255, 255)

# Font
FONT = pygame.font.SysFont("arial", 20)

# Game elements
ladders = {5: 46, 7: 15, 12: 32, 23: 51, 37: 62, 42: 78, 69: 86, 75: 94, 85: 96}
snakes = {18: 2, 26: 11, 48: 29, 53: 44, 61: 16, 77: 55, 89: 67, 92: 2}

# Load assets
snake_img = pygame.transform.scale(pygame.image.load("assets/snake.png"), (60, 60))
ladder_img = pygame.transform.scale(pygame.image.load("assets/ladder.png"), (60, 60))
token_imgs = [
    pygame.transform.scale(pygame.image.load("assets/token1.png"), (30, 30)),
    pygame.transform.scale(pygame.image.load("assets/token2.png"), (30, 30))
]

# Player data
player_positions = [0, 0]
player_colors = [(255, 0, 0), (0, 0, 255)]
player_names = ["Player 1", "Player 2"]
current_player = 0
dice_count = [0, 0]

# Load previous score
def load_last_score():
    try:
        with open("scores.txt", "r") as f:
            lines = f.readlines()
            return lines[-1].strip() if lines else "No previous scores."
    except FileNotFoundError:
        return "No score file found."

last_score = load_last_score()

# Get pixel coordinates for a position
def get_coordinates(pos):
    if pos == 0:
        return -50, -50
    row = (pos - 1) // COLS
    col = (pos - 1) % COLS if row % 2 == 0 else COLS - 1 - (pos - 1) % COLS
    x = col * CELL_SIZE + CELL_SIZE // 2
    y = HEIGHT - (row * CELL_SIZE + CELL_SIZE // 2)
    return x, y

# Draw the board
def draw_board():
    screen.fill(DARK_GRAY)
    for row in range(ROWS):
        for col in range(COLS):
            color = DARK_BLUE if (row + col) % 2 == 0 else DARK_GRAY
            pygame.draw.rect(screen, color, (col * CELL_SIZE, row * CELL_SIZE, CELL_SIZE, CELL_SIZE))
            num = row * COLS + (col + 1 if row % 2 == 0 else COLS - col)
            text = FONT.render(str(num), True, WHITE)
            screen.blit(text, (col * CELL_SIZE + 5, row * CELL_SIZE + 5))

    for start, end in ladders.items():
        x1, y1 = get_coordinates(start)
        screen.blit(ladder_img, (x1 - 30, y1 - 30))

    for start, end in snakes.items():
        x1, y1 = get_coordinates(start)
        screen.blit(snake_img, (x1 - 30, y1 - 30))

    for idx, pos in enumerate(player_positions):
        if pos > 0:
            x, y = get_coordinates(pos)
            screen.blit(token_imgs[idx], (x - 15 + (idx * 10), y - 15))

    pygame.draw.rect(screen, WHITE, (0, HEIGHT, WIDTH, 100))
    text = FONT.render(f"{player_names[current_player]}'s turn - Press SPACE to roll", True, BLACK)
    screen.blit(text, (10, HEIGHT + 10))
    screen.blit(FONT.render("Last game: " + last_score, True, BLACK), (10, HEIGHT + 40))

def draw_dice(value):
    pygame.draw.rect(screen, WHITE, (250, 610, 100, 80))
    pygame.draw.rect(screen, BLACK, (250, 610, 100, 80), 3)
    dice_text = FONT.render(f"Dice: {value}", True, BLACK)
    screen.blit(dice_text, (265, 640))

# Dice animation
def roll_dice_animation():
    for _ in range(10):
        fake_roll = random.randint(1, 6)
        draw_board()
        draw_dice(fake_roll)
        pygame.display.update()
        pygame.time.delay(80)
    return random.randint(1, 6)

# Game loop
running = True
message = ""
while running:
    draw_board()
    pygame.display.update()

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
            break

        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_SPACE:
                dice = roll_dice_animation()
                dice_count[current_player] += 1
                pos = player_positions[current_player]
                new_pos = pos + dice

                if new_pos <= 100:
                    player_positions[current_player] = new_pos
                    if new_pos in ladders:
                        player_positions[current_player] = ladders[new_pos]
                    elif new_pos in snakes:
                        player_positions[current_player] = snakes[new_pos]

                    if player_positions[current_player] == 100:
                        message = f"{player_names[current_player]} wins in {dice_count[current_player]} rolls!"
                        with open("scores.txt", "a") as f:
                            f.write(message + "\n")
                        draw_board()
                        pygame.display.update()
                        pygame.time.delay(2000)
                        running = False
                        break

                current_player = (current_player + 1) % 2

pygame.quit()
sys.exit()
