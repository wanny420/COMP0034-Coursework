/*
Write queries to answer the following questions
Save your work to this .sql file
Right click on the file name in the Project pane and select Refactor > Rename, and replace STU_NUM with your student number.
*/

--1. Which employees have 'IT' in their job title? (list their EmployeeId, FirstName, LastName and Title)
SELECT e.Title
FROM EMPLOYEE e
WHERE Title like '%IT%';



--2. List the names of all Artists and the titles of their albums
SELECT DISTINCT a.name, alb.Title
FROM artist a
         JOIN Album alb ON alb.ArtistId = a.ArtistId;



--3. Which track is features on the greatest number of times in playlists and how many times is it included? (display Trac


-- This shows the top 50 occurring songs - this is because 41 of them occur 5 times (maximally).
SELECT DISTINCT t.Name, COUNT(*)
FROM Track t
         JOIN PlaylistTrack pt ON pt.TrackId = t.TrackId
         JOIN Playlist p ON p.PlaylistId = pt.PlaylistId
Group By pt.TrackId
ORDER BY COUNT(*) DESC
LIMIT 50;




--4. Provide a list of the number of tracks by each artist
SELECT DISTINCT a.name, COUNT(*) AS "number of tracks"
FROM artist a
         JOIN Album alb ON alb.ArtistId = a.ArtistId
         JOIN Track t ON t.AlbumId = alb.AlbumId
Group By a.name
ORDER BY COUNT(*) DESC;





--5. How much money has been invoiced for the artist Deep Purple? (display each line item from the invoices and the total amount)


--this is the one to show how much they made from each track -> the "multiple" column displays the amount earned per song (the result of cost*quantity), the Invoice ID shows which order the songs were part of
SELECT DISTINCT t.name, t.UnitPrice, i.Quantity, (t.UnitPrice*i.Quantity) AS "multiple", i.InvoiceId
FROM artist a
         JOIN Album alb ON alb.ArtistId = a.ArtistId
         JOIN Track t ON t.AlbumId = alb.AlbumId
         JOIN InvoiceLine i on i.TrackId = t.TrackId
WHERE a.name = 'Deep Purple'
ORDER BY a.name;

--this one will show the total amount made from the Artist Deep Purple
SELECT DISTINCT a.name, SUM(t.UnitPrice*i.Quantity)
FROM artist a
         JOIN Album alb ON alb.ArtistId = a.ArtistId
         JOIN Track t ON t.AlbumId = alb.AlbumId
         JOIN InvoiceLine i on i.TrackId = t.TrackId
WHERE a.name = 'Deep Purple'
ORDER BY a.name;