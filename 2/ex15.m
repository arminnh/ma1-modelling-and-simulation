load('MovieLens20M_Subset.mat')

n = 25;

profile on
fprintf('Processing actualBestMovies...\n')
[movieIDs, scores] = r0679689_actualBestMovies(R);
topNScoresAndMovies = [num2str(scores(1:n), '%.2f,'), ...
                       num2str(movieIDs(1:n), '%i, '), ...
                       char(movieLabel(movieIDs(1:n)))];
disp(topNScoresAndMovies)

fprintf('Processing rank1MatrixPursuit...\n')
[U20, s20, V20, ~] = r0679689_rank1MatrixPursuit(R, 20, T);
fprintf('Processing predictedBestMovies...\n')
[movieIDs, scores] = r0679689_predictedBestMovies(U20, s20, V20);
topNScoresAndMovies = [num2str(scores(1:n), '%.2f,'), ...
                       num2str(movieIDs(1:n), '%i, '), ...
                       char(movieLabel(movieIDs(1:n)))];
disp(topNScoresAndMovies)
profile viewer

%{
OUTPUT

Processing actualBestMovies...
4.31, 938,Band of Brothers (2001)                                                   
4.29,4455,Death on the Staircase (Soupçons) (2004)                                  
4.24, 510,City of God (Cidade de Deus) (2002)                                       
4.23,1750,Lives of Others, The (Das leben der Anderen) (2006)                       
4.23,2486,Dark Knight, The (2008)                                                   
4.20, 390,Spirited Away (Sen to Chihiro no kamikakushi) (2001)                      
4.20, 183,Amelie (Fabuleux destin d'Amélie Poulain, Le) (2001)                      
4.18,4418,Frozen Planet (2011)                                                      
4.18,3477,Inception (2010)                                                          
4.16, 822,Lord of the Rings: The Return of the King, The (2003)                     
4.15,4066,Intouchables (2011)                                                       
4.15, 194,Lord of the Rings: The Fellowship of the Ring, The (2001)                 
4.14,4158,Black Mirror (2011)                                                       
4.13,4227,Bleak House (2005)                                                        
4.12, 483,Lord of the Rings: The Two Towers, The (2002)                             
4.11, 892,Eternal Sunshine of the Spotless Mind (2004)                              
4.11,1932,Departed, The (2006)                                                      
4.10, 825,Fog of War: Eleven Lessons from the Life of Robert S. McNamara, The (2003)
4.10,4781,Whiplash (2014)                                                           
4.09,1227,Old Boy (2003)                                                            
4.08,4549,Louis C.K.: Oh My God (2013)                                              
4.08,3786,Louis C.K.: Shameless (2007)                                              
4.08,4755,Normal Heart, The (2014)                                                  
4.08, 942,Best of Youth, The (La meglio gioventù) (2003)                            
4.07,3784,Louis C.K.: Chewed Up (2008)                  
      
Processing predictedBestMovies...                      
4.09, 183,Amelie (Fabuleux destin d'Amélie Poulain, Le) (2001)         
4.07, 822,Lord of the Rings: The Return of the King, The (2003)        
4.07,2486,Dark Knight, The (2008)                                      
4.06, 194,Lord of the Rings: The Fellowship of the Ring, The (2001)    
4.04, 892,Eternal Sunshine of the Spotless Mind (2004)                 
4.03, 483,Lord of the Rings: The Two Towers, The (2002)                
4.00, 510,City of God (Cidade de Deus) (2002)                          
3.99, 390,Spirited Away (Sen to Chihiro no kamikakushi) (2001)         
3.97,1932,Departed, The (2006)                                         
3.95,3477,Inception (2010)                                             
3.92, 154,Donnie Darko (2001)                                          
3.91,1456,Batman Begins (2005)                                         
3.90, 497,Pianist, The (2002)                                          
3.90,1928,Pan's Labyrinth (Laberinto del fauno, El) (2006)             
3.90, 196,Beautiful Mind, A (2001)                                     
3.90,2586,WALL·E (2008)                                                
3.90,1955,Prestige, The (2006)                                         
3.88, 761,Kill Bill: Vol. 1 (2003)                                     
3.87, 625,Finding Nemo (2003)                                          
3.87,2336,No Country for Old Men (2007)                                
3.86,1109,Incredibles, The (2004)                                      
3.86, 310,Bourne Identity, The (2002)                                  
3.86,1738,V for Vendetta (2006)                                        
3.85, 652,Pirates of the Caribbean: The Curse of the Black Pearl (2003)
3.85,2944,Inglourious Basterds (2009)                                  

%}