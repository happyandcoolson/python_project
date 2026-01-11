import pygame
from pygame.rect import Rect
import random


# pygame setup
pygame.init()
SCREEN_WIDTH = 600
SCREEN_HEIGHT=400
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
clock = pygame.time.Clock()
running = True

resize_img = lambda img,w,h : pygame.transform.scale(img, (w,h))
bg_img = pygame.image.load('cat.jpg')
bg_img = resize_img(bg_img, SCREEN_WIDTH, SCREEN_HEIGHT)
bg_rect = bg_img.get_rect()
sm_img = pygame.image.load('a boy.png')
loc1 = [300, 370] #플레이어
r1 = Rect(*loc1, 40, 20)
loc2=[200, 200]
r2=Rect(*loc2, 20, 20)
bad_things=[]
n=0
while running:
    n += 1
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    if n % 30 == 0:
        loc2_x = random.randint(0,580)
        loc2=[loc2_x, 0]
        r2=Rect(*loc2, 20,20)
        bad_things.append(r2)
    for i in bad_things:
        if i.colliderect(r1) == True:
            running = False
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT]:
        loc1[0] -= 1
    if keys[pygame.K_RIGHT]:
        loc1[0] += 1
    if keys[pygame.K_UP]:
        loc1[1] -= 1
    if keys[pygame.K_DOWN]:
        loc1[1] += 1
    r1 = Rect(*loc1, 40, 20)
    if r1.colliderect(r2) == True:
        running = False
    for i in range(len(bad_things)):
        bad_things[i][1] += 1
    print(bad_things)

    # fill the screen with a color to wipe away anything from last frame
    screen.blit(bg_img, bg_rect)

    # RENDER YOUR GAME HERE
    pygame.draw.rect(screen, (255, 0,0), r1)
    for i in bad_things:
        pygame.draw.rect(screen, (0,0,0), i)
    # flip() the display to put your work on screen
    pygame.display.flip()

    clock.tick(60)  # limits FPS to 60

pygame.quit()
