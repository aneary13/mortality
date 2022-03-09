select itemid, label
from d_items
WHERE linksto = 'chartevents'
ORDER BY label