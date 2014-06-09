import os,sys
parentdir = os.path.dirname(os.path.abspath(__file__))+'/Libraries/'
print(parentdir)
sys.path.insert(1,parentdir) 
from Mastermind import *
