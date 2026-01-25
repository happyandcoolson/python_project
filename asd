import pygame
import sys
import random
# pygame setup
pygame.init()
screen = pygame.display.set_mode((600, 400))
pygame.display.set_caption("Snake game")
clock = pygame.time.Clock()
font = pygame.font.SysFont(None, 36) # 스코어용
big_font = pygame.font.SysFont(None, 60) # 게임 오버용
size = 20
# 뱀의 초기 위치
dx, dy = 0, 0
speed = 20
color = {'black' : (0,0,0), 'blue' : (0,0,255), 'red':(255,0,0), 'white':(255,255,255)}

def random_pos(l):
    while True:
        x=random.randrange(0,600,size)
        y = random.randrange(0, 400, size)
        if (x,y) in l:
            continue
        else:
            return x, y

apple = 400,200
score = 0
snake=[(200, 200), (180,200), (160,200)]
running = True

game_over = False
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_UP and dy == 0:
                dx,dy = 0, -speed
            elif event.key == pygame.K_DOWN and dy == 0:
                dx,dy = 0, speed
            elif event.key == pygame.K_LEFT and dx == 0:
                dx, dy = -speed,0
            elif event.key == pygame.K_RIGHT and dx == 0:
                dx,dy = speed, 0

    if not game_over:
        head_x, head_y = snake[0]
        new_head = (head_x+dx, head_y + dy)

        if new_head[0] < 0 or 600 <= new_head[0] or new_head[1] < 0 or 400 <= new_head[1]:
            game_over = True

        if new_head in snake[1:] and dx != dy:
            game_over = True
        snake.insert(0, new_head)
        if new_head == apple:
            score += 1
            apple = random_pos(snake)
        else:
        # 꼬리 제거
            snake.pop()

    screen.fill(color['black']) # 배경 색상 검정색
    for x, y in snake:
        pygame.draw.rect(screen, color['blue'], (x, y, size, size))
    pygame.draw.rect(screen, color['red'], (apple[0], apple[1], size,size))
    score_text = font.render(f"Score: {score}", True, color["white"])
    screen.blit(score_text, (10,10))
    pygame.display.update() # while문이 반복될 때 화면 새로고침

    if game_over:
        over_text = big_font.render("GAME OVER", True, color['white'])
        screen.blit(over_text, (180,150))
        screen.blit(score_text, (250,250))
    pygame.display.update()
    clock.tick(40)  # limits FPS to 60
