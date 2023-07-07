    --Given a DNA sequence s (consisting Of bases A, C, G, And T), find all the open reading frames (ORFs) In that sequence.
    --An ORF begins at the base triplet ATG (=start codon), And ends at the first occuring Stop codon: TTA, TAG Or TGG.
    --Note, that start codon And stop codon need to be in the same reading frame, which means that they have to be separated by 0, 3, 6,... bases. Also note, that ORFs can overlap.
    --Report the number Of found ORFs. For Each ORF, report its index (0-based indexing) And the sequence (including start And Stop codon)
    --sort them In descending order Of their len gth And sort ORFs With equal lengths by their ascending index.
    --Input
    --Line 1: A word s, which represents the DNA sequence.
    --Output
    --The number Of found ORFs n, followed by n lines reporting the index And sequence Of all ORFs. The ORFs need To be sorted by length (descending) And In Case Of ties by index (ascending).
    --Constraints
    --6 <= length of s <= 60
    --Example
    --Input
    --CATGTAATGG
    --Output
    --1
    --1 ATGTAATGG
    --create table dna_frames(
    --str_  varchar(255))
    --insert into dna_frames values ('ATGTTAATGTAGATGTGG'), ('CATGTAATGG'), ('CATGTAATGGTTATAGTGG'), ('ABCATG'), ('TTATAGTGG'),(''),('TGGATG'),('ATGCTGG'),('TGGCATG')
    declare @solutions table (dna varchar(255), frame varchar(255));
    declare @str varchar(255)='';
    DECLARE @num int=0;
DECLARE cursorDna CURSOR FOR select * from dna_frames;
OPEN cursorDna;
FETCH NEXT FROM cursorDna  INTO @str;
WHILE @@FETCH_STATUS = 0
BEGIN
declare @initial table(index_ int);
    declare @final table(index_ int);
    delete @initial;
    delete @final;
    declare @i int=1;
    while @i<=LEN(@str)-2
    BEGIN
    if SUBSTRING(@str,@i,3)='ATG'
    BEGIN
    insert into @initial select @i;
    END
    else if  SUBSTRING( @str,@i,3) in ('TTA','TAG', 'TGG')--TTA, TAG Or TGG
    BEGIN
    insert into @final select @i;
    END
    set @i+=1
    END;
    with q1 as(
    select i.index_ i0, f.index_ f0 from
    @initial i
    inner join @final f
    on i.index_<f.index_ and ((f.index_-i.index_) % 3=0)
    )
    insert into @solutions select @str, SUBSTRING(@str,i0,f0-i0+3) from q1;
  --here your logic for the row
  FETCH NEXT FROM cursorDna INTO @str; --this should be always the last one
END
CLOSE cursorDna;
DEALLOCATE cursorDna;
select * from @solutions;
    
    --select * from log_messages;
    --truncate table log_messages;
    --select * from log_messages;