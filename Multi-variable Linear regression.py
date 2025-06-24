# #1.IMPORT MODULES/ LIBRARIES
# import pandas as pd
# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn import linear_model
# import pickle
# # from sklearn.externals import joblib
#
# #2. TAKE INPUT FILE
# df = pd.read_excel('Weather.xlsx')
# print(df)
#
# #3. SELECT SUITABLE ALGORITHM
# model = linear_model.LinearRegression()
#
# #4. TRAIN DATA , DEFINE INPUT AND OUTPUT
# model.fit(df[['Humidity (%)','Wind Speed (km/h)','Precipitation (mm)','Atmospheric Pressure (hPa)']],df.Temperature)
#
# #5. PREDICT THE OUTPUT
# # hum = int(input("enter the Humidity (%)  = "))
# # ws = int(input("enter the Wind speed = "))
# # pre = int(input("enter the Precipitation = "))
# # ap = int(input("enter the Atmospheric Pressure = "))
#
# df_output = pd.read_excel('Find.xlsx')
# temp = model.predict(df_output)
# print("The predicted Temperature is =",temp)
#
# #6. CREATE THE MODEL
# # fm = open('weather_model','wb')
# # pickle.dump(model,fm)
# # fm.close()
#
import pygame
import random
import sys

# Initialize Pygame
pygame.init()

# Constants
WIDTH, HEIGHT = 600, 600
ROWS, COLS = 10, 10
CELL_SIZE = WIDTH // COLS
FONT = pygame.font.SysFont("arial", 20)

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
TEXT_COLOR = (255, 255, 255)
DARK_BLUE = (25, 25, 112)
DARK_GRAY = (50, 50, 50)
LADDER_COLOR = (50, 200, 50)
SNAKE_COLOR = (200, 50, 50)
RED = (255, 0, 0)

# Setup screen
screen = pygame.display.set_mode((WIDTH, HEIGHT + 100))
pygame.display.set_caption("Snake and Ladders")

# Snakes and Ladders
ladders = {5: 46, 7: 15, 12: 32, 23: 51, 37: 62, 42: 78, 69: 86, 75: 94, 85: 96}
snakes = {18: 2, 26: 11, 48: 29, 53: 44, 61: 16, 77: 55, 89: 67, 92: 2}

# Player
position = 1
dice_count = 0
dice_result = 0
message = ""

# Convert board position to (x, y) - NOW FIXED
def get_coordinates(pos):
    if pos < 1 or pos > 100:
        return (-100, -100)
    row = (pos - 1) // 10
    col = (pos - 1) % 10
    if row % 2 == 0:
        x = col * CELL_SIZE
    else:
        x = (9 - col) * CELL_SIZE
    y = HEIGHT - ((row + 1) * CELL_SIZE)
    return x + CELL_SIZE // 2, y + CELL_SIZE // 2

# Draw the game board - NOW FIXED
def draw_board():
    screen.fill(WHITE)
    for row in range(ROWS):
        for col in range(COLS):
            rect = pygame.Rect(col * CELL_SIZE, row * CELL_SIZE, CELL_SIZE, CELL_SIZE)
            color = DARK_GRAY if (row + col) % 2 == 0 else DARK_BLUE
            pygame.draw.rect(screen, color, rect)

            # Correct number: count from 1 (bottom-left) to 100 (top-right)
            actual_row = 9 - row
            num = actual_row * 10 + (col + 1 if actual_row % 2 == 0 else 10 - col)
            text = FONT.render(str(num), True, TEXT_COLOR)
            screen.blit(text, (rect.x + 5, rect.y + 5))

    # Draw Ladders
    for start, end in ladders.items():
        x1, y1 = get_coordinates(start)
        x2, y2 = get_coordinates(end)
        pygame.draw.line(screen, LADDER_COLOR, (x1, y1), (x2, y2), 5)

    # Draw Snakes
    for start, end in snakes.items():
        x1, y1 = get_coordinates(start)
        x2, y2 = get_coordinates(end)
        pygame.draw.line(screen, SNAKE_COLOR, (x1, y1), (x2, y2), 5)

# Roll the dice
def roll_dice():
    return random.randint(1, 6)

# Game loop
running = True
clock = pygame.time.Clock()
player_color = RED

while running:
    clock.tick(5)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

        if event.type == pygame.KEYDOWN and position < 100:
            if event.key == pygame.K_SPACE:
                dice_result = roll_dice()
                next_pos = position + dice_result
                message = f"You rolled a {dice_result}!"

                if next_pos <= 100:
                    position = next_pos
                    dice_count += 1

                    if position in ladders:
                        message += "  🎉 Wow!! Ladder is here, move up!"
                        position = ladders[position]
                    elif position in snakes:
                        message += "  🐍 Sad for you, snake bites you, get down."
                        position = snakes[position]

    draw_board()

    # Draw player token
    x, y = get_coordinates(position)
    pygame.draw.circle(screen, player_color, (x, y), 20)

    # Draw bottom panel
    pygame.draw.rect(screen, WHITE, (0, HEIGHT, WIDTH, 100))
    dice_text = FONT.render(f"Dice Roll: {dice_result} | Rolls: {dice_count}", True, BLACK)
    msg_text = FONT.render(message, True, BLACK)
    instruction_text = FONT.render("Press SPACE to roll the dice", True, BLACK)

    screen.blit(dice_text, (20, HEIGHT + 10))
    screen.blit(msg_text, (20, HEIGHT + 40))
    screen.blit(instruction_text, (20, HEIGHT + 70))

    if position == 100:
        win_text = FONT.render("🎉 Congratulations! You reached 100!", True, RED)
        screen.blit(win_text, (120, HEIGHT + 40))

    pygame.display.flip()

